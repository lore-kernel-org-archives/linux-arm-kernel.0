From: bp@alien8.de (Borislav Petkov)
Date: Tue, 12 Jan 2016 15:36:53 +0100
Subject: [PATCH v3 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
In-Reply-To: <CAGDN=zZOr6+q8aAdXB3gnSLfCm6gX-6KLaFPr+A4QMf+TPwR-w@mail.gmail.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <1446857519-5908-2-git-send-email-lho@apm.com>
 <20160110110714.GA22896@pd.tnic>
 <CAGDN=zYa1r23EphdYQTFe2YXRhg_P-RDiaZVms9rdbFA3Y-x3g@mail.gmail.com>
 <20160111221305.GH4665@pd.tnic>
 <CAGDN=zZOr6+q8aAdXB3gnSLfCm6gX-6KLaFPr+A4QMf+TPwR-w@mail.gmail.com>
Message-ID: <20160112143653.GB30558@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 02:41:41PM -0800, Tuan Phan wrote:
> It will be problem because irq number can be 0 on X86?

tglx says not really but historically irq 0 has been the timer irq.

How about returning a negative value on error and positive or 0 for an
IRQ?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
