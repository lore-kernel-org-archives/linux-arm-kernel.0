From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Wed, 11 Aug 2010 21:57:25 +0300
Subject: [PATCH v4 3/8] wireless: wl1271: add platform driver to get
	board data
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0324110AC1@dbde02.ent.ti.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
	<1281550913-17633-4-git-send-email-ohad@wizery.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com>
	<20100811184742.GA21778@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110AC1@dbde02.ent.ti.com>
Message-ID: <20100811185724.GD21778@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 11, 2010 at 08:52:54PM +0200, ext DebBarma, Tarun Kanti wrote:
>True; however if we go by that argument than we can also assume pdata 
>is valid, so that we would not need the below check.

of course not. You can have devices that just play well with default 
values or devices where you don't need the flexibility of platform data. 
That's why we check.

platform_device pointers on the other hand, are guaranteed to be always 
true, if it isn't then you should oops, you deserve to oops because 
something is really really wrong.

>Still, I would go ahead and find out if there is any scenario where 
>pdev can go wrong during device registration. Thanks.

if that scenario ever happens, it's either a bug on your implementation 
or driver-core. In both cases you deserve to oops so we catch such 
problems at early stages.

-- 
balbi

DefectiveByDesign.org
