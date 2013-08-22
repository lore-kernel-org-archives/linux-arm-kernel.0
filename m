From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 21 Aug 2013 23:19:30 -0700
Subject: [RFC PATCH 2/3] clk: update users of "clk_register_mux" and
 "DEFINE_CLK_MUX"
In-Reply-To: <1375778065-21808-3-git-send-email-chander.kashyap@linaro.org>
References: <1375778065-21808-1-git-send-email-chander.kashyap@linaro.org>
 <1375778065-21808-3-git-send-email-chander.kashyap@linaro.org>
Message-ID: <20130822061930.8231.89917@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Chander Kashyap (2013-08-06 01:34:24)
> As with the patch "clk-add-support-for-temporary-parent-clock-migration.patch"
> a new field "alternate_parent_name", is added to clk structure. This field can
> be passed using clk_register_mux API and DEFINE_CLK_MUX macro.

Nitpick: it's easier to search for the patch you mentioned if you quote
the actual patch $SUBJECT instead of the name of the patch file. In this
case, "clk: add support for temporary parent clock migration".

This invasive change is not necessary if the temporary parent stuff is
not added to the clock core and is instead left to the .set_parent
callbacks of custom clock providers.

Regards,
Mike
