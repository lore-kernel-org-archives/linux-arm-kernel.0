From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Sat, 17 Oct 2015 10:42:02 +0530
Subject: [RESEND v4.1 0/5] Mailbox: Provide support STi based platforms
In-Reply-To: <1444980091-16728-1-git-send-email-lee.jones@linaro.org>
References: <1444980091-16728-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CAJe_Zhfzvoz2FFN5XSg=O1PY-JT_Y0XCNj+PVSmWtnXq6LQJ4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 October 2015 at 12:51, Lee Jones <lee.jones@linaro.org> wrote:
> Hi Jassi,
>
> [Resending the updated patch-set this time]
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
> v2 => v3:
>  - Controller
>    - Shared (DT <=> Device Driver) defines removed
>    - Return actual error codes instead of NULL in xlate()
>    - Not passing 'direction' configuration via DT anymore
>      - Removed all accompanying configuration checking code
>  - Test F/W
>    - Allow Rx-only and Tx-only controllers to be tested
>    - Cater for controllers requiring pre-Tx 'signal' to be sent
>    - Supply 'wr-' message debugfs file
>      - When written to, will Tx message through Mailbox Framework
>      - When read from, will print out a hexdump of Rx'ed message
>
> v1 => v2:
>  - New MACRO() to obtain base address for a given instance
>  - Move locking into the structure it protects
>  - Stop checking for 'ready' state when sending data
>  - Don't clear channel data (that belongs to the API)
>  - #define register offsets instead of providing via pdata
>  - Register driver with module_platform_driver()
>
> Lee Jones (5):
>   mailbox: dt: Supply bindings for ST's Mailbox IP
>   mailbox: Add support for ST's Mailbox IP
>   ARM: STi: stih407-family: Add nodes for Mailbox
>   mailbox: Add generic mechanism for testing Mailbox Controllers
>   ARM: STi: DT: STiH407: Enable Mailbox testing facility
>
Picked patches 1,2 & 4. Thanks for overhauling the old drivers, now we
have fewer lines and simpler but more complete driver.

Thanks.
