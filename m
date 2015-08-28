From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 28 Aug 2015 13:01:06 -0700
Subject: [PATCH] spmi: pmic-arb: Don't byte swap when reading/writing FIFO
In-Reply-To: <1440789702-1648-1-git-send-email-sboyd@codeaurora.org>
References: <1440789702-1648-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150828200106.GU13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 28 Aug 12:21 PDT 2015, Stephen Boyd wrote:

> We don't want to swap bytes that we're reading and writing to the
> FIFOs when we're running on a big-endian CPU. Doing so causes
> problems like where the qcom-spmi-iadc driver can't detect the
> type of device because the bytes are all mixed up. Use the raw IO
> accessors for these API instead, and collapse pmic_arb_base_read()
> into the byte reading API so that we aren't tempted to read non-FIFO
> data like commands with that function.
> 
> Cc: Andy Gross <agross@codeaurora.org>

Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
