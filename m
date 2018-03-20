From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 20 Mar 2018 10:52:42 +0100
Subject: [RESEND PATCH v1 2/6] i2c: i2c-stm32f7: Add slave support
In-Reply-To: <5a3c5b21-bc66-ce73-a997-f686ecc275f3@st.com>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-3-git-send-email-pierre-yves.mordret@st.com>
 <20180317205109.gocf5wemtjkyomct@ninjato>
 <5a3c5b21-bc66-ce73-a997-f686ecc275f3@st.com>
Message-ID: <20180320095242.tedafu5wphsx55qx@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I do believe the hw can support it, even it looks odd to me having the same I2C
> in slave and master mode at the same time.

I2C is multi-master, so it is perfectly valid for a device to be master
and slave. I do have seen designs making use of that more than once.

> Nevertheless the driver is devised to support either master or slave more but
> not at the same time.

Why should we limit ourselves here? Also, why should we have an
unnecessary configuration option?

Unless the HW is broken and does not support it, I usually don't accept
slave-only solutions. If the needs for master and slave arises later,
this is hard to refactor and better done properly right away.

Is it so hard? Usually you have irqs for master and for slave seperated,
so you can code things quite orthogonal. Check de20d1857dd6 ("i2c: rcar:
add slave support") as an example.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180320/60212771/attachment-0001.sig>
