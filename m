From: ccross@android.com (Colin Cross)
Date: Wed, 23 Feb 2011 11:26:42 -0800
Subject: [PATCH v2] i2c: tegra: Add i2c support
In-Reply-To: <20110223002059.GV15795@trinity.fluff.org>
References: <AANLkTim0X=gUwYJmR+EAYjGamiJb7tgiVEjwqCEF0-L0@mail.gmail.com>
	<1298250861-27094-1-git-send-email-ccross@android.com>
	<20110223002059.GV15795@trinity.fluff.org>
Message-ID: <AANLkTi=wtxzKGHXgtoUsV8J4O3NUYdz9PGHi-sdd-Osy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22, 2011 at 4:20 PM, Ben Dooks <ben-i2c@fluff.org> wrote:
> On Sun, Feb 20, 2011 at 05:14:21PM -0800, Colin Cross wrote:
>> Adds I2C bus driver for nVidia Tegra SoCs. ?Tegra includes 4 I2C
>> controllers, one of which is inside the Dynamic Voltage Controller
>> and has a slightly different register map.
>>
>> Signed-off-by: Colin Cross <ccross@android.com>
>
> Would have been helpful to start a new thread, missed this the first time
> around.
>
>> + ? ? i2c_dev = kzalloc(sizeof(struct tegra_i2c_dev), GFP_KERNEL);
>> + ? ? if (!i2c_dev) {
>
> no error print here.
>
>> + ? ? ? ? ? ? ret = -ENOMEM;
>> + ? ? ? ? ? ? goto err_i2c_clk_put;
>> + ? ? }
>
>> + ? ? if (pdev->id == 3)
>> + ? ? ? ? ? ? i2c_dev->is_dvc = 1;
>> + ? ? init_completion(&i2c_dev->msg_complete);
>
> you might want to think about having a seperate platform bus name for
> this case, and switching the is_dvc field on that. It'll make life much
> easier if someone decides that what the next tegra i2c needs is 5 i2c
> controllers.
>
> I'll consider putting this (as is) into the -next tree, but would like
> to see the issues with readsl/writesl sorted out and any other review
> comments sorted.
>
Thanks for merging it.  Can I merge your i2c-tegra tree into the tegra
for-next tree to allow some board changes that depend on the header to
go on top?
