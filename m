From: Yuval.Mintz@qlogic.com (Yuval Mintz)
Date: Thu, 11 Aug 2016 09:36:10 +0000
Subject: [PATCH 04/21] net: thunderx: Set queue count based on number of
 CPUs
In-Reply-To: <1470811373-28277-5-git-send-email-sunil.kovvuri@gmail.com>
References: <1470811373-28277-1-git-send-email-sunil.kovvuri@gmail.com>
 <1470811373-28277-5-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <CO2PR11MB008837F849AB5891E076DF41971E0@CO2PR11MB0088.namprd11.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 81xx has only 4 CPUs, so it doesn't make sense to initialize entire Qset i.e 8
> queues by default. Made changes to queue initialization to init queues equal to
> number of CPUs or
> 8 queues whichever is lesser. Also this will be applicable to VMs with VNIC VF
> attached and having less VCPUs
...
> -	qcount = MAX_CMP_QUEUES_PER_QS;
> +	qcount = min_t(int, MAX_CMP_QUEUES_PER_QS, num_online_cpus());

We have netif_get_num_default_rss_queues() which does this.
