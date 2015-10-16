From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 16 Oct 2015 09:48:54 +0530
Subject: [PATCH v4 0/5] Mailbox: Provide support STi based platforms
In-Reply-To: <1444050140-24733-1-git-send-email-lee.jones@linaro.org>
References: <1444050140-24733-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CAJe_ZhcBwSxOAwssztipQtYzG8mPQ4Wmu+=h47gT3vc4gv7mJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2015 at 18:32, Lee Jones <lee.jones@linaro.org> wrote:
> Hi Jassi,
>
> This should be it.  Exciting times!
>
> ST's platforms currently support a maximum of 5 Mailboxes, one for
> each of the supported co-processors situated on the platform.  Each
> Mailbox is divided up into 4 instances which consist of 32 channels.
> Messages are passed between the application and co-processors using
> shared memory areas.
>
> Also included in the set is an example Client which should be generic
> enough to use as a testing environment for all Mailbox IPs which use
> shared memory or the API to pass messages.  With small changes, it
> should also be able to test more extravagant implementations.
>
> v3 -> v4:
>  - More protection in MBOX_BASE() MACRO
>  - Remove unused tx-only marker
>
Are you sure about the tx-only marker? :)

Since it is also a DT property, I think we should have it removed
before we apply the patchset. Lets get it done today.

Thanks
