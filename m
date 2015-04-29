From: lho@apm.com (Loc Ho)
Date: Wed, 29 Apr 2015 15:20:20 -0700
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <20150429220830.GI5498@pd.tnic>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <1430259045-19012-2-git-send-email-lho@apm.com>
 <1430259045-19012-3-git-send-email-lho@apm.com>
 <1430259045-19012-4-git-send-email-lho@apm.com>
 <CAL_Jsq+nhPUxHxrStB9cdy1YzE7tVPFVR1MrWq3Bz-JUa=3Rvg@mail.gmail.com>
 <CAPw-ZTnLR10Zr_p8L3-1nBZ+jKE1HCwERDmO=S5as2GLqime3A@mail.gmail.com>
 <20150429214924.GH5498@pd.tnic>
 <CAPw-ZTmoash48S3F8kBxsovD0mEPYBO8=XDaJ2peDu60yaGrZQ@mail.gmail.com>
 <20150429220830.GI5498@pd.tnic>
Message-ID: <CAPw-ZT=YjmAEAEHH6tB4ZebnC6RQywm4=JiHoJv_MULPSGF7sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

>> >> > Similar comments for the rest. I would define memory controller
>> >> > bindings and EDAC driver, then worry about the rest.
>> >>
>> >> Okay.. As comment in following emails, I will break up the driver into
>> >> multiple drivers and focus only on the memory controller driver first.
>> >
>> > Please no multiple EDAC drivers. Or do you mean something else here?
>>
>> We will have the following:
>>
>> xgene-edac-mc.c
>> xgene-edac-pmd.c
>> xgene-edac-l3.c
>> xgene-edac-soc.c
>>
>> Or what would you suggest.
>
> xgene-edac.c
>
> This granularity is insane. On x86 we have single EDAC drivers for
> multiple CPU families and platforms.
>
> You can start carving out stuff when this is absolutely needed, i.e.
> when an IP block is in multiple hw incarnations. And even then I'd be
> sceptical and would really want to know whether it is even worth it to
> have an EDAC module for it.
>
> So let's be conservative please.

For now, let me just deal with the DDR module.

Rob,

Did I answered all your questions regarding the EDAC DT binding for
memory controller? I would like to get this sorted out before I post
another version.

-Loc
