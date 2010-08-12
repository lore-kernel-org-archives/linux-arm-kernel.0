From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Thu, 12 Aug 2010 08:21:26 +0300
Subject: [PATCH v4 3/8] wireless: wl1271: add platform driver to get
	board data
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0324110AC7@dbde02.ent.ti.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
	<1281550913-17633-4-git-send-email-ohad@wizery.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com>
	<20100811184742.GA21778@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110AC1@dbde02.ent.ti.com>
	<20100811185724.GD21778@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110AC7@dbde02.ent.ti.com>
Message-ID: <20100812052126.GA23362@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 11, 2010 at 09:27:18PM +0200, ext DebBarma, Tarun Kanti wrote:
>Sounds perfect!
>What that means is _probe() function makes sense only for cases where 
>we have valid platform data because we are returning right at the top 
>if pdata is not valid. If this is the case I was curious to know why 
>not framework make another check for valid pdata before calling 
>_probe() instead of coming all the way to _probe() and then returning!

because pdata is completely optional. pdev OTOH isn't. Without a matched 
platform_device, your probe() won't get called.

-- 
balbi

DefectiveByDesign.org
