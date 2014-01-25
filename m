From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Sat, 25 Jan 2014 18:32:26 -0300
Subject: [PATCH 0/4] clk: mvebu: fix clk init order
In-Reply-To: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <52E42D6A.5050508@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sebastian,

El 25/01/14 15:19, Sebastian Hesselbarth escribi?:
> This patch set fixes clk init order that went upside-down with
> v3.14. I haven't really investigated what caused this, but I assume
> it is related with DT node reordering by addresses.

The framework should be able to deal with unordered registration. I am 
not very familiar with the mvebu driver though, do you have a valid 
reason to require a specific order?

> Anyway, with v3.14 for MVEBU SoCs, the clock gating driver gets
> registered before core clocks driver. Unfortunately, we cannot
> return -EPROBE_DEFER in drivers initialized by clk_of_init.

Why would you need to do so? After a quick inspection on the code, I see 
you may have problems on mvebu_clk_gating_setup() when getting the 
default parent clock name, but I believe you could solve it in an easier 
way by using of_clk_get_parent_name().

Cheers,

Emilio
