From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 29 May 2014 10:53:52 +0200
Subject: [PATCH v2 7/9] arm64: KVM: add trap handlers for AArch32 debug
 registers
In-Reply-To: <53860830.4080707@arm.com>
References: <1400604945-25247-1-git-send-email-marc.zyngier@arm.com>
 <1400604945-25247-8-git-send-email-marc.zyngier@arm.com>
 <20140525153546.GH3866@lvm> <53860830.4080707@arm.com>
Message-ID: <20140529085352.GC61607@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 05:00:48PM +0100, Marc Zyngier wrote:
> On 25/05/14 16:35, Christoffer Dall wrote:
> > On Tue, May 20, 2014 at 05:55:43PM +0100, Marc Zyngier wrote:

[...]

> >> +
> >> +	/* DBGDSAR (32bit) */
> >> +	{ Op1( 0), CRn( 2), CRm( 0), Op2( 0), trap_raz_wi },
> >> +
> > 
> > we don't handle access to any implementation defined debug registers?
> > Did we actually check what would be implemented for the cores we
> > support?
> 
> No. So far, I've stuck with what the ARM ARM describe. Unless you're
> thinking of a particular register I may ignored?
> 
I was just wondering if there are any implementation defined registers
on the cores we claim to support (a15/a57/a53), and if so, if we
shouldn't add some handlers for those for completeness sake.  I didn't
actually check.  Did you?

-Christoffer
