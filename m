From: ludovic.barre@stericsson.com (frq09524)
Date: Tue, 22 May 2012 14:51:23 +0200
Subject: [PATCH 1/7] remoteproc: resource table overhaul
In-Reply-To: <CAK=WgbYKMh8oifeC-A9LYq8GV_Nb7L8wc198YZujGEsp9mmvsw@mail.gmail.com>
References: <1330589497-4139-1-git-send-email-ohad@wizery.com>
 <1330589497-4139-2-git-send-email-ohad@wizery.com>
 <4F6354E4.8030704@monstr.eu>
 <CAK=Wgbbbi4GnuHedSh6cR1LhkZr8c9q6i=_TLSL252LpPB8Xsw@mail.gmail.com>
 <CAK=WgbYeQr5ZwTSBo+ZJUzN7fQ--0QbC8HSjrGT-Geycs4SKcg@mail.gmail.com>
 <CAHTX3d+=QTZo994jct6+pPqsCniG0B2a_9q6fLdGjvcbZ7qj_A@mail.gmail.com>
 <CAK=WgbahzGHmvszw6HBgihN4NcPA8ceaQCNSOk_FC61bToxBXQ@mail.gmail.com>
 <CAHTX3dK8rDomYqWvBX1ay200AmM1dBCYD3nJ2UYbzC_SSFankw@mail.gmail.com>
 <4FBB5908.4010505@stericsson.com>
 <CAK=WgbYKMh8oifeC-A9LYq8GV_Nb7L8wc198YZujGEsp9mmvsw@mail.gmail.com>
Message-ID: <4FBB8BCB.3010802@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Ohad

In my previous patch, to find the correct subdevice that match with 
physical memory, I used pa member of rproc_mem_entry.
but today in these 2 resources: fw_rsc_trace, fw_rsc_vdev_vring, pa 
menber has been removed.

for fw_rsc_trace it's not a problem, because use rproc_da_to_va and 
carveout feature.

but for fw_rsc_vdev_vring, I think use da member, like this.

dev = rproc_dma_find_dev(rproc, (phys_addr_t) vring->da);
va = dma_alloc_coherent(dev, size, &dma, GFP_KERNEL);
if (!va) {
	dev_err(dev, "dma_alloc_coherent failed\n");
	return -EINVAL;
}

are you OK ?

/BR
Ludovic Barr?

On 05/22/2012 11:22 AM, Ohad Ben-Cohen wrote:
> Hi Ludovic,
>
> On Tue, May 22, 2012 at 12:14 PM, frq09524<ludovic.barre@stericsson.com>  wrote:
>> Ohad, for alignment I can take the latest branch of kernel.org (remoteproc)
>> branch for-next?
>
> Sure, it's pretty much updated sans a few simple changes.
>
> Thanks,
> Ohad.
