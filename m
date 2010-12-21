From: nvishwan@codeaurora.org (nvishwan at codeaurora.org)
Date: Tue, 21 Dec 2010 15:44:52 -0800 (PST)
Subject: [PATCH] msm: rmnet: msm rmnet smd virtual ethernet driver
In-Reply-To: <20101215134107.0354c0c3@nehalam>
References: <1292437866-11652-1-git-send-email-nvishwan@codeaurora.org>
	<20101215134107.0354c0c3@nehalam>
Message-ID: <d141676494ae8979d4b32a337c9dba38.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, 15 Dec 2010 10:31:06 -0800
> Niranjana Vishwanathapura <nvishwan@codeaurora.org> wrote:
>
>> +static struct net_device_stats *rmnet_get_stats(struct net_device *dev)
>> +{
>> +	struct rmnet_private *p = netdev_priv(dev);
>> +	return &p->stats;
>> +}
>> +
>
> Just use dev->stats and this function would no longer be needed.
>
> --
>

This function will be a function pointer (ndo_get_stats) in net_device_ops
structure.
