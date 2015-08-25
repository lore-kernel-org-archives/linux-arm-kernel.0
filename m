From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 25 Aug 2015 21:01:49 +0800
Subject: [PATCH v1 1/3] dt-bindings: mailbox: Document Hi6220 mailbox
 driver
In-Reply-To: <55DC4EC0.4060301@arm.com>
References: <1439977055-1747-1-git-send-email-leo.yan@linaro.org>
 <1439977055-1747-2-git-send-email-leo.yan@linaro.org>
 <55DC4EC0.4060301@arm.com>
Message-ID: <20150825130149.GA28262@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

Thanks for review, please see below comment.

On Tue, Aug 25, 2015 at 12:17:20PM +0100, Sudeep Holla wrote:
> On 19/08/15 10:37, Leo Yan wrote:
> >Document the new compatible for Hisilicon Hi6220 mailbox driver.
> >
> >Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >---
> >  .../bindings/mailbox/hisilicon,hi6220-mailbox.txt  | 57 ++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt
> >
> >diff --git a/Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt b/Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt
> >new file mode 100644
> >index 0000000..3dfb0b0
> >--- /dev/null
> >+++ b/Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt
> >@@ -0,0 +1,57 @@
> >+Hisilicon Hi6220 Mailbox Driver
> >+===============================
> >+
> >+Hisilicon Hi6220 mailbox supports up to 32 channels. Each channel
> >+is unidirectional with a maximum message size of 8 words. I/O is
> >+performed using register access (there is no DMA) and the cell
> >+raises an interrupt when messages are received.
> >+
> >+Mailbox Device Node:
> >+====================
> >+
> >+Required properties:
> >+--------------------
> >+- compatible:		Shall be "hisilicon,hi6220-mbox"
> >+- reg:			Contains the mailbox register address range (base
> >+			address and length); the first item is for IPC
> >+			registers, the second item is shared buffer for
> >+			slots.
> 
> Not sure if the shared buffer needs to be part of the controller binding
> as it's not related to it. It's just agreement between the endpoints of
> this mailbox on particular SoC and IMO has to part of the client binding.

Yes, we need distinguish the buffer is really used for channel's
management or just only used for client. Here "shared buffer" is
used for channels' state machine, mode and raw data with 8 words.

So mailbox driver just read/write raw data according to client's
requirement, client will define their specific format for data
transcation.

Thanks,
Leo Yan
