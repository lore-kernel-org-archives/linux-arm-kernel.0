From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 26 Dec 2013 09:39:35 +0100
Subject: [PATCH 2/5] input: sun4i-ts: Add support for temperature sensor
In-Reply-To: <1387923847-1294-3-git-send-email-hdegoede@redhat.com>
References: <1387923847-1294-1-git-send-email-hdegoede@redhat.com>
 <1387923847-1294-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20131226093935.28890a14@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Hans de Goede,

On Tue, 24 Dec 2013 23:24:04 +0100, Hans de Goede wrote:

> +	of_property_read_u32(np, "ts-attached", &ts_attached);

ts-attached should be a boolean property, and therefore you should use
of_property_read_bool() here.

And in your Device Tree, you should use:

	ts-attached;

when a touchscreen is attached. And nothing when no touchscreen is
attached.

Note that this patch is also changing the DT binding, so it should
update the DT binding documentation created in the first patch.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
