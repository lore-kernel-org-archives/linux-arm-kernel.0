From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 20 Mar 2018 10:42:17 +0100
Subject: [RESEND PATCH v1 6/6] i2c: i2c-stm32f7: Implement I2C recovery
 mechanism
In-Reply-To: <fdc16b28-3aab-1d37-3c93-40ed371bfd4f@st.com>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-7-git-send-email-pierre-yves.mordret@st.com>
 <20180317204720.mclh4jw5owobbtww@ninjato>
 <2672947b-46b2-7bd7-ac13-501db8bde72b@st.com>
 <fdc16b28-3aab-1d37-3c93-40ed371bfd4f@st.com>
Message-ID: <20180320094216.ugietqyerdowq4c4@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Looking at the recovery API, this recovery is for slave and nothing else with my
> case. Therefore I think I have to get move this reset out of recovery API.

Yes, you are correct. You need a custom function, this is totally driver
specific.

> Slave Recovery mechanism is another story to implement in our platform since we
> have to deal with GPIOs.

For that, the recovery infrastructure in the core has lots of helpers
for you.

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180320/f307968c/attachment-0001.sig>
