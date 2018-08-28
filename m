From: dyoung@redhat.com (Dave Young)
Date: Tue, 28 Aug 2018 21:43:47 +0800
Subject: [PATCH v13 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
In-Reply-To: <20180828052107.GE12252@linaro.org>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
 <20180801075820.3753-4-takahiro.akashi@linaro.org>
 <20180801102951.527cfc57@ThinkPad>
 <20180802000150.GN11258@linaro.org>
 <20180806055047.GC4246@dhcp-128-65.nay.redhat.com>
 <20180809033416.GA5069@dhcp-128-65.nay.redhat.com>
 <1235507889.17337085.1533788045597.JavaMail.zimbra@redhat.com>
 <20180828052107.GE12252@linaro.org>
Message-ID: <20180828134347.GB12178@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi AKASHI,
On 08/28/18 at 02:21pm, AKASHI Takahiro wrote:
> Hi Dave,
> 
> On Thu, Aug 09, 2018 at 12:14:05AM -0400, Pingfan Liu wrote:
> > 
> > 
> > 
> > 
> > ----- Original Message -----
> > > From: "Dave Young" <dyoung@redhat.com>
> > > To: "AKASHI Takahiro" <takahiro.akashi@linaro.org>, "Philipp Rudo" <prudo@linux.ibm.com>, "catalin marinas"
> > > <catalin.marinas@arm.com>, "will deacon" <will.deacon@arm.com>, dhowells at redhat.com, vgoyal at redhat.com,
> > > herbert at gondor.apana.org.au, davem at davemloft.net, bhe at redhat.com, arnd at arndb.de, schwidefsky at de.ibm.com, "heiko
> > > carstens" <heiko.carstens@de.ibm.com>, "ard biesheuvel" <ard.biesheuvel@linaro.org>, "james morse"
> > > <james.morse@arm.com>, bhsharma at redhat.com, kexec at lists.infradead.org, linux-arm-kernel at lists.infradead.org,
> > > linux-kernel at vger.kernel.org, "piliu at redhat.com Thiago Jung Bauermann" <bauerman@linux.vnet.ibm.com>
> > > Sent: Thursday, August 9, 2018 11:34:16 AM
> > > Subject: Re: [PATCH v13 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
> > > 
> > > Add more cc. Pingfan Liu confirmed ppc does not use 0 as valid address,
> > > if so it should be safe.
> > > 
> > > Pingfan, can you add more words?
> > > 
> > 
> > ppc64 uses a few KB starting from 0 for exception handler.
> 
> It assures that 0 (zero) is valid, but won't be assigned as a result of
> kexec_add_buffer().
> 
> So do you think that yet I should submit another patch set, introducing
> explicit KEXEC_BUF_MEM_UNKNOWN, while assuming 0 by default is safe for now?
> 
> Now that this is the only comment against my v13, it's up to you.

I'm fine with your proposal.  It is simple enough, and we can look into
it when it becomes a problem in the future which is unlikely.

Thanks
Dave
