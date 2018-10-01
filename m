From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 1 Oct 2018 15:43:07 +0200
Subject: [PATCH V2 23/27] mmc: mmci: add variant property to request a
 reset
In-Reply-To: <a956549b-a84e-2582-1fce-3b15495f208c@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
 <1537523181-14578-24-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqxBuQcafS2KFqPDwb4=V1Jwoovb4+VsJZjAA5CeKs2kw@mail.gmail.com>
 <a956549b-a84e-2582-1fce-3b15495f208c@st.com>
Message-ID: <CAPDyKFpeifgeZcB45WE+nbRtOrGk+h0BqbNZgM2ivJiELkXJhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>> @@ -1854,6 +1855,14 @@ static int mmci_probe(struct amba_device *dev,
>>>
>>>          dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
>>>
>>> +       if (variant->reset) {
>>> +               host->rst = devm_reset_control_get_exclusive(&dev->dev,
>>> NULL);
>>
>>
>> As suggested, let's make this optional and not depending on the variant.
>
>
> I done like that because is required for my variant (if no reset, no power
> cycle for sdmmc).

The point is, I think don't think it's correct to ties this to the
variant, but rather I think it depends on the behavior of the SoC.

>
> If you prefer, I could move to optional with
> "devm_reset_control_get_optional_exclusive"
> And I add a comment in mmci dt binding to specify that not optional
> for sdmmc. (see above)

Alright, fair enough. Let' do that.

[...]

Kind regards
Uffe
