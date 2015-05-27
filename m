From: tj@kernel.org (Tejun Heo)
Date: Wed, 27 May 2015 14:09:20 -0400
Subject: [PATCH v3 1/3] ahci: Move interrupt enablement code to separate
 functions
In-Reply-To: <1432713693-4282-2-git-send-email-rric@kernel.org>
References: <1432713693-4282-1-git-send-email-rric@kernel.org>
 <1432713693-4282-2-git-send-email-rric@kernel.org>
Message-ID: <20150527180920.GR7099@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, May 27, 2015 at 10:01:31AM +0200, Robert Richter wrote:
> +static int ahci_init_intx(struct pci_dev *pdev, unsigned int n_ports,
> +			struct ahci_host_priv *hpriv)
> +{
>  	pci_intx(pdev, 1);
> +
>  	return 0;
>  }

Let's please not factor out the above as a separate function.  An one
lin function which always returns 0 doesn't really serve any purpose.

Thanks.

-- 
tejun
