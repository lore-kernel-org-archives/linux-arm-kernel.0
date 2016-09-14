From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 14 Sep 2016 08:59:32 +0200
Subject: [PATCH v9 00/19] Add support for FDMA DMA controller and slim
 core rproc found on STi chipsets
In-Reply-To: <20160913180616.GD21438@tuxbot>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
 <20160913093107.GA10953@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160913180616.GD21438@tuxbot>
Message-ID: <01669e54-8410-76cd-11f8-fce5cbeefbdc@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn

On 09/13/2016 08:06 PM, Bjorn Andersson wrote:
> On Tue 13 Sep 02:31 PDT 2016, Peter Griffin wrote:
> 
>> Hi Vinod & Bjorn,
>>
>> [..]
>>
>> On Mon, 05 Sep 2016, Peter Griffin wrote:
>>
>>> v8 actions some review feedback from Bjorn to the slim rproc driver, and also includes
>>> a patch which fixes a recursive Kconfig error which is triggered when st_fdma selects
>>> slim_rproc driver. The series has also been rebased on v4.8-rc3.
>>>
>>> v9 actions some review feedback from Bjorn, Lee and Vinod. See below. Importantly a bug
>>> was found during testing now that the platform boots without clk_ignore_unused parameter
>>> whereby the clocks would not be enabled properly before firmware loading was attempted.
>>>
>>> regards,
>>>
>>> Peter.
>>>
>>> Changes since v8:
>>>  - Add MODULE_ALIAS (Vinod)
>>>  - devm_kzalloc to devm_kcalloc (Vinod)
>>>  - quisce tasklet initialised by vchan_init() (Vinod)
>>>  - Don't make SLIM rproc user selectable (Bjorn)
>>>  - slim_rproc: Ensure clocks enabled before firmware load (Peter)
>>>  - Various code style nits / commit message change (Lee)
>>>  - Separate patch for '\n' kconfig removal (Vinod)
>>
>> I hate to send a ping,
> 
> Sorry about that.
> 
>> but do you think we can merge this fdma series? It has gone
>> through quite a few review rounds now.
>>
> 
> I think the remoteproc part looks good.
> 
> Vinod, I don't have any changes queued in remoteproc that should cause
> merge issues. If you want to you could take the remoteproc patch
> through your tree.
> 
> 
> I do however think that the dts patches should go through arm-soc.

I will take care about dts patches by adding them in the next STi DT pull request

Thanks
Patrice

> 
> Regards,
> Bjorn
> 
