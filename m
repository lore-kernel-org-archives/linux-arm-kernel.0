From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Mar 2015 11:16:36 -0400 (EDT)
Subject: [PATCH] ARM: force linker to use PIC veneers
In-Reply-To: <CAKv+Gu-MpvAnkEd2L_OPGpDv5cnCZACvzuQ9LbG8O5kjDRQUwQ@mail.gmail.com>
References: <1427192184-31261-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150324122239.GB3579@e103592.cambridge.arm.com>
 <CAKv+Gu-MpvAnkEd2L_OPGpDv5cnCZACvzuQ9LbG8O5kjDRQUwQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1503241112420.27567@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Mar 2015, Ard Biesheuvel wrote:

> On 24 March 2015 at 13:22, Dave Martin <Dave.Martin@arm.com> wrote:
> > How many such veneers get added in the your kernel configuration, and
> > how many are actually necessary (i.e., calls between MMU-off code and
> > elsewhere)?
> >
> 
> Very few. In addition to the example (which will be addressed in
> another way regardless) there are some resume functions that get
> allocated in .data, and those would need it as well.


What are they? I thought we removed all instances of those already.

> I have also proposed b_far/bl_far macros that could be used there as 
> well.

Could the automatic veneer insertion replace the unconditional 
b_far/bl_far usage?  The former would be preferable to the later.


Nicolas
