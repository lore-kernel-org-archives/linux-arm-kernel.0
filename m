From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 28 Feb 2018 14:46:13 +0530
Subject: [PATCH 3/3] mailbox: sunxi-msgbox: Add a new mailbox driver
In-Reply-To: <20180228022714.30068-4-samuel@sholland.org>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-4-samuel@sholland.org>
Message-ID: <CABb+yY2uueAK9kzXzU9DT2a4NtV3kK2dc_wtyFWTBn8=Z6Vi7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 7:57 AM, Samuel Holland <samuel@sholland.org> wrote:
....

> +/*
> + * The message box hardware provides 8 unidirectional channels. As the mailbox
> + * framework expects them to be bidirectional
>
That is incorrect. Mailbox framework does not require a channel to be
TX and RX capable.

You should expose each channel as per its physical capability, let the
client configure it for direction (if its bidirectional) and acquire
separate channels for RX and TX if it needs to.

Cheers!
