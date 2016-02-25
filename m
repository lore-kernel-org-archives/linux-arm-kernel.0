From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 25 Feb 2016 17:48:49 -0600
Subject: [PATCH v3 6/8] arm64: dts: qcom: fix usb digital voltage levels
In-Reply-To: <CAPBZ5QfD4q4hDg2Vfj8E_2Hjoa80feFN4cM+LkhdGgHLDkKx_g@mail.gmail.com>
References: <1456246153-18087-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1456246236-18341-1-git-send-email-srinivas.kandagatla@linaro.org>
 <56CE3780.5060408@codeaurora.org> <56CEE3D4.3030407@linaro.org>
 <CAPBZ5QfD4q4hDg2Vfj8E_2Hjoa80feFN4cM+LkhdGgHLDkKx_g@mail.gmail.com>
Message-ID: <CAPBZ5QeJGV5iqx5wwGP3mwr292-rkqmORnTe8qtHSX2DzVc97Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think the vdd-levels were an oversight.  The voltages definitely
need to be correct.  As for the corner regulators, I believe the CPR
driver was supposed to address this.  The USB requests a specific
voltage and frequency and based on this the CPR would set the corner
for the regulator.

Stephen, correct me if i am wrong.

On 25 February 2016 at 17:44, Andy Gross <andy.gross@linaro.org> wrote:
> I think the vdd-levels were an oversight.  The voltages definitely need to
> be correct.  As for the corner regulators, I believe the CPR driver was
> supposed to address this.  The USB requests a specific voltage and frequency
> and based on this the CPR would set the corner for the regulator.
>
> Stephen, correct me if i am wrong.
>
> On 25 February 2016 at 05:21, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>>
>>
>> On 24/02/16 23:06, Stephen Boyd wrote:
>>>
>>> On 02/23/2016 08:50 AM, Srinivas Kandagatla wrote:
>>>>
>>>> This patch updates the digital voltage levels from corner values to
>>>> microvolts as we are going to use s1 regulator directly for vddcx
>>>> instead of s1_corner.
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> ---
>>>
>>>
>>> What's the plan for corners? Maybe we should remove the voltage setting
>>> from the usb driver or drop the usb node entirely on msm8916 until we
>>> resolve how we're going to handle corners. I'd like to avoid getting
>>> stuck into some DT binding ABI mess here.
>>
>>
>> Andy/Bjorn, any comments on plans on corner regulators?
>>
>> Please note, that this is a patch to fix what is already in the mainline.
>> Without this patch the regulator would be configured with 1uV or 5uV or 7uV
>> which would obviously fail.
>>
>> THB, it does not make sense to drop feature which is functional, and I
>> also agree that we should cleanup some of this mess at some point in time
>> once we all the bits and pieces ready.
>>
>> I was surprised to see these usb bindings(qcom,vdd-levels) existed even
>> before we had concept of corner regulators in mainline kernel. Which also
>> suggests that this driver needs a proper relook once again.
>>
>> Thanks,
>> srini
>
>
