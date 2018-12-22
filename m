Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60D8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:00:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739C0218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BqEfEQ1C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+OLUMN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739C0218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SqGD8H0wUKLpZ/fIqijBXG58pruSWfGj3nvie1Mj4hQ=; b=BqEfEQ1CENOR6U
	GbExZXcbEeYYL2HOyo7CSTFgdbcKyovXwGBFtl1uvfQjv20JkPrIeC3eiHC82XEvRVati8o4J8s4l
	WaQFn6327EuRy7fMjdsUeirdHdU5cfTzzOw7HWIQx65i50hd2qW55ydeW8ez6ZWdrBsCukz4ZQGc0
	wLkZa94DE2fAdu6D6abN8vf7nUAic+ZMvk3epsozPJG13ClVm+IC/Il7GWczKGzv5Sz9vrluRbNbS
	uhKrnKCTDDlo12lACzOkoktzbJns+btg0es4fH+2lrETciapatPK8xRUDDSXeJXynq0eIZL+aeOfI
	a6msj1FjnbYzcxodVnlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaWaN-0004jk-DI; Sat, 22 Dec 2018 02:00:15 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaWaK-0003UJ-0M
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 02:00:13 +0000
Received: by mail-io1-xd43.google.com with SMTP id o13so3800544ioh.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 18:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aZt2eyagM4lqMLEpi1b+c4/zgJkxTUDtvq67TbKB9vA=;
 b=I+OLUMN6z+8+P1cLDLfncLEfJnqV1hNMlZ8a2oowX/1qYJojSOnTzPYZ+7UwF0vSSv
 T+fk+p74TATcqe+5c9Y/uhDwYx976YelKyrSAkWN1mjemyT8PI1/2yLee6dNy1lD/68S
 c9s0UAM6zZE3eRIPQw7xomcre0XjabKJSDkpeodpHb9vBiqgXarGuV4pdAiVwg0RyBVt
 G6ODCqspTlp+3pL9qq1bgVXeYGBTPHHVZ4KeX675eTVksRs9s3vh5iHefjMdhvA2E8RZ
 5F92g1LkckujYzjoWYk3qtBnZIPLqaqb4gv1gi7epySfgUsss++4Z9HKd8tPqCzoZHYn
 31lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aZt2eyagM4lqMLEpi1b+c4/zgJkxTUDtvq67TbKB9vA=;
 b=or2Dw9Qe9YZYynFer8fsOZeAEkjc57TvMsdfVU74k+QWt7P51wQN9jL7wppGxJHXQ6
 8oJcbOq2I803EJlLXwsTeMqktO7ZFxBGB9iDpGTioDHRO7l7RkUrJxmSPpVA/TFuHDN8
 /MutUbSFboCFpNRrsu0WTiDho8tXFgDFN7TPx5a6fP5QJSOk9PXz4DO8t+C9utHNj+ze
 xky5mSYJ/8L3NSRVfIUVOr3KooKjvKOBo0/Gn1oCeMnP3yA8CTT4vSaSxxv+RrmfzJvL
 yuD8hWEMbFclNkTpi9et9jc7emvy4HXAyCfFLf4K2mr6MwG9GfYqP5MUtWMRrCAyJc1a
 qMvA==
X-Gm-Message-State: AJcUukeJQNmkDmrTy33YTVtcuQ9rQNMhaY7PxU4qpNPjncEYOhe4Wy3r
 aN5bxT3FPvCl6C5ioDpUb9GXLxOblmZTpDVEMJ8=
X-Google-Smtp-Source: ALg8bN5lGzM10ohfDS88bSHvblLouIzY9uRTT11D7WM3gsbZ0F2bw4uyrngP8ARoepHJudRu0RIAW1xCoyMmyAoQYz0=
X-Received: by 2002:a6b:a0d:: with SMTP id z13mr3203284ioi.57.1545444000039;
 Fri, 21 Dec 2018 18:00:00 -0800 (PST)
MIME-Version: 1.0
References: <1545327149-22331-1-git-send-email-wendy.liang@xilinx.com>
 <1545327149-22331-2-git-send-email-wendy.liang@xilinx.com>
In-Reply-To: <1545327149-22331-2-git-send-email-wendy.liang@xilinx.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Fri, 21 Dec 2018 19:59:48 -0600
Message-ID: <CABb+yY27K8V-Mg_0kvQFvvAGhzdXG+7Zcz9tGDe_1FTStvra3Q@mail.gmail.com>
Subject: Re: [PATH v7 1/2] mailbox: ZynqMP IPI mailbox controller
To: Wendy Liang <wendy.liang@xilinx.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_180012_054847_23B5D520 
X-CRM114-Status: GOOD (  20.92  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Devicetree List <devicetree@vger.kernel.org>,
 Michal Simek <michal.simek@xilinx.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 11:32 AM Wendy Liang <wendy.liang@xilinx.com> wrote:


> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> new file mode 100644
> index 0000000..bbddfd5
> --- /dev/null
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -0,0 +1,764 @@

......
> +
> +/* IPI SMC Macros */
> +#define IPI_SMC_OPEN_IRQ_MASK          0x00000001UL /* IRQ enable bit in IPI
> +                                                     * open SMC call
> +                                                     */
> +#define IPI_SMC_NOTIFY_BLOCK_MASK      0x00000001UL /* Flag to indicate if
> +                                                     * IPI notification needs
> +                                                     * to be blocking.
> +                                                     */
> +#define IPI_SMC_ENQUIRY_DIRQ_MASK      0x00000001UL /* Flag to indicate if
> +                                                     * notification interrupt
> +                                                     * to be disabled.
> +                                                     */
> +#define IPI_SMC_ACK_EIRQ_MASK          0x00000001UL /* Flag to indicate if
> +                                                     * notification interrupt
> +                                                     * to be enabled.
> +                                                     */
> +
The first two are unused.


> +struct zynqmp_ipi_pdata {
> +       struct device *dev;
> +       int irq;
> +       unsigned int method;
>
'method' doesn't track the HVC option in the driver. Please have a look.

......
> +
> +static void zynqmp_ipi_fw_call(struct zynqmp_ipi_mbox *ipi_mbox,
> +                              unsigned long a0, unsigned long a3,
> +                              unsigned long a4, unsigned long a5,
> +                              unsigned long a6, unsigned long a7,
> +                              struct arm_smccc_res *res)
>
[a4,a7] are always 0, so maybe just drop them?


> +static bool zynqmp_ipi_last_tx_done(struct mbox_chan *chan)
> +{
> +       struct device *dev = chan->mbox->dev;
> +       struct zynqmp_ipi_mbox *ipi_mbox = dev_get_drvdata(dev);
> +       struct zynqmp_ipi_mchan *mchan = chan->con_priv;
> +       int ret;
> +       u64 arg0;
> +       struct arm_smccc_res res;
> +       struct zynqmp_ipi_message *msg;
> +
> +       if (WARN_ON(!ipi_mbox)) {
> +               dev_err(dev, "no platform drv data??\n");
> +               return false;
> +       }
> +
> +       if (mchan->chan_type == IPI_MB_CHNL_TX) {
> +               /* We only need to check if the message been taken
> +                * by the remote in the TX channel
> +                */
> +               arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
> +               zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
> +               /* Check the SMC call status, a0 of the result */
> +               ret = (int)(res.a0 & 0xFFFFFFFF);
> +               if (ret < 0 || ret & IPI_MB_STATUS_SEND_PENDING)
> +                       return false;
> +
OK, but ...

> +               msg = mchan->rx_buf;
> +               msg->len = mchan->resp_buf_size;
> +               memcpy_fromio(msg->data, mchan->resp_buf, msg->len);
> +               mbox_chan_received_data(chan, (void *)msg);
>
.... wouldn't this be done from zynqmp_ipi_interrupt()?



> +static int zynqmp_ipi_send_data(struct mbox_chan *chan, void *data)
> +{
  .........
> +               /* Enquire if the mailbox is free to send message */
> +               arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
> +               timeout = 10;
> +               if (msg && msg->len) {
> +                       timeout = 10;
> +                       do {
> +                               zynqmp_ipi_fw_call(ipi_mbox, arg0,
> +                                                  0, 0, 0, 0, 0, &res);
> +                               ret = res.a0 & 0xFFFFFFFF;
> +                               if (ret >= 0 &&
> +                                   !(ret & IPI_MB_STATUS_SEND_PENDING))
> +                                       break;
> +                               usleep_range(1, 2);
> +                               timeout--;
> +                       } while (timeout);
> +                       if (!timeout) {
> +                               dev_warn(dev, "chan %d sending msg timeout.\n",
> +                                        ipi_mbox->remote_id);
> +                               return -ETIME;
> +                       }
> +                       memcpy_toio(mchan->req_buf, msg->data, msg->len);
> +               }
>
This check should be done in last_tx_done, and not here.
send_data is never called unless last_tx_done returns true.

> +               /* Kick IPI mailbox to send message */
> +               arg0 = SMC_IPI_MAILBOX_NOTIFY;
> +               zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
> +       } else {
> +               /* Send response message */
> +               if (msg && msg->len > mchan->resp_buf_size) {
> +                       dev_err(dev, "channel %d message length %u > max %lu\n",
> +                               mchan->chan_type, (unsigned int)msg->len,
> +                               mchan->resp_buf_size);
> +                       return -EINVAL;
> +               }
> +               if (msg && msg->len)
> +                       memcpy_toio(mchan->resp_buf, msg->data, msg->len);
>

> +               arg0 = SMC_IPI_MAILBOX_NOTIFY;
> +               arg0 = SMC_IPI_MAILBOX_ACK;
>
This is obviously wrong.

....
> +       mbox->chans = chans;
> +       chans[IPI_MB_CHNL_TX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_TX];
> +       chans[IPI_MB_CHNL_RX].con_priv = &ipi_mbox->mchans[IPI_MB_CHNL_RX];
> +       ipi_mbox->mchans[IPI_MB_CHNL_TX].chan_type = IPI_MB_CHNL_TX;
> +       ipi_mbox->mchans[IPI_MB_CHNL_RX].chan_type = IPI_MB_CHNL_RX;
> +       ret = mbox_controller_register(mbox);
>
while at it, you may want to start using
devm_mbox_controller_register() recently added by Thierry.

> +       if (ret)
> +               dev_err(mdev,
> +                       "Failed to register mbox_controller(%d)\n", ret);
> +       else
> +               dev_info(mdev, "Probed ZynqMP IPI Mailbox driver.\n");
>
You may want to also print something instance specific here.


> +static int zynqmp_ipi_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *nc, *np = pdev->dev.of_node;
> +       struct zynqmp_ipi_pdata *pdata;
> +       struct zynqmp_ipi_mbox *mbox;
> +       int i, ret = -EINVAL;
> +
> +       i = 0;
> +       for_each_available_child_of_node(np, nc)
> +               i++;
>
of_get_child_count() ?


Thnx

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
