From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Sat, 20 Jul 2013 12:55:36 +0200
Subject: [PATCH] net: Add MOXA ART SoCs ethernet driver
In-Reply-To: <1374140806-12485-1-git-send-email-jonas.jensen@gmail.com>
References: <1374140806-12485-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <CACmBeS0ztqKWJ1uLKhb2EZdexspTq5t0uHZfPotHiAPHfkftoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think this driver may have a bug.

After some time running ping successfully, the message "no TX space
for packet" is printed resulting in 100% packet loss.

The message is printed from .ndo_start_xmit and I think it may be
because of how priv->tx_desc_now is now set up in
moxart_mac_setup_desc_ring.

I will take a look at this and try to fix the issue.

Best regards,
Jonas
