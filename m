From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 27 Jan 2017 18:56:13 +0000
Subject: [PATCH v30 05/11] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170127171513.GA3119@fireball>
References: <20170124084638.3770-1-takahiro.akashi@linaro.org>
 <20170124085004.3892-4-takahiro.akashi@linaro.org>
 <5888E262.4050208@arm.com> <20170126112811.GG23406@linaro.org>
 <588B2CC4.70904@arm.com> <20170127171513.GA3119@fireball>
Message-ID: <20170127185612.GA31485@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 28, 2017 at 02:15:16AM +0900, AKASHI Takahiro wrote:
> On Fri, Jan 27, 2017 at 11:19:32AM +0000, James Morse wrote:
> > Hi Akashi,
> >
> > On 26/01/17 11:28, AKASHI Takahiro wrote:
> > > On Wed, Jan 25, 2017 at 05:37:38PM +0000, James Morse wrote:
> > >> On 24/01/17 08:49, AKASHI Takahiro wrote:
> > >>> To protect the memory reserved for crash dump kernel once after loaded,
> > >>> arch_kexec_protect_crashres/unprotect_crashres() are meant to deal with
> > >>> permissions of the corresponding kernel mappings.
> > >>>
> > >>> We also have to
> > >>> - put the region in an isolated mapping, and
> > >>> - move copying kexec's control_code_page to machine_kexec_prepare()
> > >>> so that the region will be completely read-only after loading.
> > >>
> > >>
> > >>> Note that the region must reside in linear mapping and have corresponding
> > >>> page structures in order to be potentially freed by shrinking it through
> > >>> /sys/kernel/kexec_crash_size.

Ah; I did not realise that this was a possibility.

> Now I understand why we should stick with page_mapping_only option.

Likewise, I now agree.

Apologies for guiding you down the wrong path here.

Thanks,
Mark.
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
