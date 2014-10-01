From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 1 Oct 2014 10:45:48 -0300
Subject: [PATCH v3 2/4] ARM: dts: pbab01: enable I2S audio on
 phyFLEX-i.MX6 boards
In-Reply-To: <542C0441.5080508@sam-solutions.com>
References: <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410854903-26419-3-git-send-email-d.lavnikevich@sam-solutions.com>
 <CAOMZO5CgrQ6Wf6kStga40TUKx9dARygCNB4OYSUoG3c8eUYbrA@mail.gmail.com>
 <542C0441.5080508@sam-solutions.com>
Message-ID: <CAOMZO5BS6X2NTY4q7RKoKdhJNbEANSa2wXur3_Hyxp8nQn5Avw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 1, 2014 at 10:40 AM, Dmitry Lavnikevich
<d.lavnikevich@sam-solutions.com> wrote:

>> No need to have this 'regulator-always-on'
>>
>
> why is there no need for 'regulator-alweys-on'? I see it in

For a regulator that is not GPIO controlled you don't need to pass
'regulator-always-on'.

>
>>> +&ssi2 {
>>> +       fsl,mode = "i2s-slave";
>>
>>
>> Please remove this 'fsl,mode' property. It is ignored by the fsl_ssi
>> driver.
>
>
> yes, thanks. It is present in Documentation but now I see that it
> was actually removed not that long ago. I will remove this
> property with next patchset.

Correct, I recently sent a patch removing it and it is in Mark's tree now:
https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/?h=topic/fsl-ssi&id=b93427b1c057841602e0fe2005153a6e82f2e658
