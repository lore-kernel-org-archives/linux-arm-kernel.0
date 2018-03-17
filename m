From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 17 Mar 2018 21:47:20 +0100
Subject: [RESEND PATCH v1 6/6] i2c: i2c-stm32f7: Implement I2C recovery
 mechanism
In-Reply-To: <1520852023-27083-7-git-send-email-pierre-yves.mordret@st.com>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-7-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20180317204720.mclh4jw5owobbtww@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 11:53:43AM +0100, Pierre-Yves MORDRET wrote:
> Feature prevents I2C lock-ups. Mechanism resets I2C state machine
> and releases SCL/SDA signals but preserves I2C registers.

Does it release SDA when held down by the slave? Because that is what
the recovery mechanism is for.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180317/639d9b04/attachment.sig>
