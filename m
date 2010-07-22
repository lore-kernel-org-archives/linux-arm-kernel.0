From: me@felipebalbi.com (Felipe Balbi)
Date: Thu, 22 Jul 2010 19:40:44 +0300
Subject: [PATCH 2/2] USB: musb: omap2430: add mode change from A to B
In-Reply-To: <877hknwnrb.fsf@anar.kanru.info>
References: <1268648622-28529-1-git-send-email-Hui.Wang@windriver.com>
	<1268648622-28529-2-git-send-email-Hui.Wang@windriver.com>
	<877hknwnrb.fsf@anar.kanru.info>
Message-ID: <4C48748C.8040307@felipebalbi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2010 06:16 PM, Kan-Ru Chen wrote:
> Just curious about how to do this in a more automatic way.
> 
> I think setup a daemon to monitor the musb_hdrc mode and try to alter
> it's state via sysfs interface will work, but it may be error prone and
> not always desirable solution.
> 
> Can we query the id pin state periodically in the kernel and change to
> corresponding role?

the transceiver has an interrupt for id pin changes. You can use that
instead of polling.

-- 
balbi
