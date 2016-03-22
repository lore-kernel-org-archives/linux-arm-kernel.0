From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 22 Mar 2016 06:15:10 -0500
Subject: [PATCH v5 1/6] of/serial: move earlycon early_param handling to
 serial
In-Reply-To: <1458643595-14719-2-git-send-email-aleksey.makarov@linaro.org>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
 <1458643595-14719-2-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <CAL_JsqL+YU7qSze40c+M5AaOvpZDFgvg=SsRGmpT3k_=L6P8JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 5:46 AM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> From: Leif Lindholm <leif.lindholm@linaro.org>
>
> We have multiple "earlycon" early_param handlers - merge the DT one into
> the main earlycon one.  It's a cleanup that also will be useful
> to decide if ACPI SPCR earlycon should be set up.

How so? Isn't that determined by whether we have ACPI tables or a DT?

This goes against trying to limit places of FDT parsing and keeping
the early scanning all within fdt.c. At least it is not in the arch
code. That said, I'm okay with this change if it helps.

Rob
