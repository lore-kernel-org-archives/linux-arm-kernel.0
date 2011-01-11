From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 10 Jan 2011 22:21:42 -0700
Subject: [RFC] arm: Defer lookup of machine_type and vet of atags to
	setup.c
In-Reply-To: <alpine.LFD.2.00.1101102211370.12076@xanadu.home>
References: <20110111015409.18291.87166.stgit@localhost6.localdomain6>
	<alpine.LFD.2.00.1101102211370.12076@xanadu.home>
Message-ID: <AANLkTimBOJUVx1eqsTQmmmPm4v=K2b_BGyrsV-YR45fu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 10, 2011 at 8:19 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Mon, 10 Jan 2011, Grant Likely wrote:
>
>> Since the debug macros no longer depend on the machine type
>> information, both the machine type lookup and the atags vetting can be
>> deferred to setup_arch() in setup.c which simplifies the code
>> somewhat.
>>
>> This patch removes both __machine_type_lookup and __vet_atags() from
>> head.S. ?The atags vetting is moved to setup_arch(). ?machine_type
>> lookup is already called from setup_machine() in addition to where it
>> was called from head.S.
>
> While at it, you could also remove the code for __lookup_machine_type,
> lookup_machine_type and __error_a, replacing that with a C
> implementation living in setup.c instead. ?If this code is not called
> from head.S anymore, there is no reason to keep it there any longer.

Certainly.  I'll draft that up as a separate patch and post it tomorrow.

g.
