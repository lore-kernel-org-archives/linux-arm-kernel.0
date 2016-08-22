From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 22 Aug 2016 17:00:58 +0200
Subject: [PATCH v3 05/12] firmware: tegra: Add BPMP support
In-Reply-To: <6bb4d32f-4f13-285e-430e-672f375a9a46@nvidia.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-6-thierry.reding@gmail.com>
 <94227d94-1d60-fda7-731b-26656633d585@nvidia.com>
 <20160822125458.GC17367@ulmo.ba.sec>
 <6bb4d32f-4f13-285e-430e-672f375a9a46@nvidia.com>
Message-ID: <20160822150058.GA21012@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 03:24:28PM +0100, Jon Hunter wrote:
> 
> On 22/08/16 13:54, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> > 
> > On Mon, Aug 22, 2016 at 10:26:50AM +0100, Jon Hunter wrote:
> >>
> >> On 19/08/16 18:32, Thierry Reding wrote:
> >>> From: Thierry Reding <treding@nvidia.com>
> >>>
> >>> The Boot and Power Management Processor (BPMP) is a co-processor found
> >>> on Tegra SoCs. It is designed to handle the early stages of the boot
> >>> process and offload power management tasks (such as clocks, resets,
> >>> powergates, ...) as well as system control services.
> >>>
> >>> Compared to the ARM SCPI, the services provided by BPMP are message-
> >>> based rather than method-based. The BPMP firmware driver provides the
> >>> services to transmit data to and receive data from the BPMP. Users can
> >>> also register an MRQ, for which a service routine will be run when a
> >>> corresponding event is received from the firmware.
> >>
> >> MRQ?
> > 
> > I think that means "Message ReQuest", which is sort of like an IRQ but
> > the user will receive a message (with potentially payload) instead. Do
> > you want me to spell that out in the commit message, or what would you
> > suggest?
> 
> I think that if we simply say 'Message ReQuest (MRQ)" it becomes clearer
> what this is. Otherwise, google returns everything from 'most recent
> quarter' to canadian rock bands :-)

Okay, done.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/ecdf72bc/attachment.sig>
