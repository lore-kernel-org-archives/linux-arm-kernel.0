From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 26 Sep 2014 08:45:42 -0600
Subject: [PATCH v6 1/5] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <20140924192945.GC1004@ilina-mac.local>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
 <1411516281-58328-2-git-send-email-lina.iyer@linaro.org>
 <F743E5F0-28C1-4A9D-A27D-73EA70A01B46@codeaurora.org>
 <20140924172151.GD422@ilina-mac>
 <4BFC9B4E-A3D0-422E-9B55-0DB9F4B04EE9@codeaurora.org>
 <20140924192945.GC1004@ilina-mac.local>
Message-ID: <20140926144542.GA390@ilina-mac.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24 2014 at 13:30 -0600, Lina Iyer wrote:
>On Wed, Sep 24 2014 at 11:53 -0600, Kumar Gala wrote:
>>
>>On Sep 24, 2014, at 12:21 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>
>>>On Wed, Sep 24 2014 at 10:33 -0600, Kumar Gala wrote:
>>>>
>>>>On Sep 23, 2014, at 6:51 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>>>
>>>>+- qcom,saw2-delays: The SPM delay values that SPM sequences would refer to.
>>>>>+	The register for this property is MSM_SPM_REG_SAW2_SPM_DLY.
>>>>
>>>>Didn?t Stephen asked about splitting this up? Or at least treating it as an array of 3 values?
>>>>
>>>Yes he did. My response was similar to the clk-div values, its not
>>>something you can change without hardware spec documentation.
>>>And I need to mix the three values up, anyways before I write to the
>>>register. Splitting it up, doesnt help understanding/configuring the SPM
>>>any better, so didnt change it.
>>
>>Hmm, will this value change from SPM to SPM on the same SoC?  I?m not a fan of allowing random register values to get poked into the HW from DT.  While this one case might end up being acceptable, its a terrible practice and not something I want use in the habit of doing.
>>
>Ah. Tough proposition! The SPM sequence is a bunch of random register
>values, which is not open to interpretation without the programming
>guides. I am not sure how I can use DT for saving all the register data
>then.
>
>I agree its nice to have nice readable parameters in the DT, but, isnt
>the purpose of the DT, the hardware configuration? In an alternate way
>to do this, I could put all these register writes into the driver itself
>for each SoC. Ugly as it may be, it would solve the problem. However,
>the device node then just has the compatible string in it and may be
>some configurable elements. I fail to see the big picture of the use of
>DT in such a case.
>
>FWIW, I do understand your stance with DT, and for the most part agree
>with it.
>
Based on our offline discussion, I will make the changes to move these
proprietary register values into the driver. I will submit a patch with
the changes soon.

Thanks,
Lina.
