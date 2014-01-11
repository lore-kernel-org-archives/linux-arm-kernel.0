From: tj@kernel.org (Tejun Heo)
Date: Sat, 11 Jan 2014 14:31:04 -0500
Subject: [PATCH v8 3/4] ata: Add APM X-Gene SoC SATA host controller driver
In-Reply-To: <52D052F9.8050703@redhat.com>
References: <1389031922-4309-1-git-send-email-lho@apm.com>
 <1389031922-4309-2-git-send-email-lho@apm.com>
 <1389031922-4309-3-git-send-email-lho@apm.com>
 <1389031922-4309-4-git-send-email-lho@apm.com>
 <52D052F9.8050703@redhat.com>
Message-ID: <20140111193104.GD3257@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, David.

On Fri, Jan 10, 2014 at 02:07:21PM -0600, David Milburn wrote:
> Tejun, to avoid some of the interrupt handling code duplication, would
> it better to have a AHCI_HFLAG_FLUSH and then change
> 
> this driver to set flush
> 
> hpriv->hpriv.flush = (void *) xgene_ahci_iob_flush;
> 
> and then standard code flush when necessary
> 
> ahci_handle_port_interrupt
> 
>        /* board-specific flush before servicing completed cmds */
>        if (hpriv-> flags & AHCI_HFLAG_FLUSH)
>                hpriv->flush(hpriv);

And this would be the only spot that this would be necessary?  If so,
why not just wrap the interrupt handler?

Thanks.

-- 
tejun
