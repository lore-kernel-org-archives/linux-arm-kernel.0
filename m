From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 30 Aug 2011 22:02:35 +0800
Subject: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
In-Reply-To: <Pine.LNX.4.44L0.1108291218040.2525-100000@iolanthe.rowland.org>
References: <CACVXFVNFXh33tsvkM=jdnc8OocVhjkzpt6LK59zKa9L2F7HxpQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1108291218040.2525-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVPDuq5tDsFVaGo5gWJVJ+g3MqK1O5+bUD7_d086_1xKZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

Thanks for your comment.

On Tue, Aug 30, 2011 at 12:33 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> Nevertheless, it remains true that you want to add a memory barrier
> instruction simply in order to speed up a cache writeback, not to force
> any sort of ordering. ?This needs to be explained carefully in the code
> (not just in the patch description!) and it needs to be done in a way
> that won't affect other architectures.

OK, will do it.

> Also, as you mentioned before, you may want to do the same thing in
> qh_link_async() just after the
>
> ? ? ? ?head->hw->hw_next = dma;
>
> line. ?Delays in flushing that write would also slow down performance.

Will do it too.


thanks,
--
Ming Lei
