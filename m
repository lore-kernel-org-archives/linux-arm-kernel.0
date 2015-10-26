From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 26 Oct 2015 07:46:42 -0500
Subject: [PATCH v13 5/5] uart: pl011: Add support to ZTE ZX296702 uart
In-Reply-To: <562DF96D.6020307@arm.com>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-6-git-send-email-jun.nie@linaro.org>
 <55FC16A2.5070207@arm.com>
 <CABymUCOA3oG7Hq83hDyQ_uisQHeipoHshcWONWTtjxKvikzjsQ@mail.gmail.com>
 <CAOZdJXUjZLKkUYScD7oDTMuRUtAEJ6=DopmE4n6Vb9zyv+_viA@mail.gmail.com>
 <CABymUCORU9CDD64Rdw2VX0kLSe6E1zY9iZCap5xittoVFwbOtw@mail.gmail.com>
 <562AFBD5.3050508@codeaurora.org> <562DF96D.6020307@arm.com>
Message-ID: <562E20B2.4050805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andre Przywara wrote:
> I tried to refactor the driver lately to split up SBSA and PL011 support
> and got something that compiles, though I wasn't fully satisfied and I
> ran out of time. The refactor idea was to split driver runtime from
> initialization, so the different probe and init functions can be moved
> into separate files. There would be one stub file with all the core
> driver logic (DMA, IRQ handling, buffer handling, communication
> parameters setup) and one file for each subtype (PL011, SBSA, ZTE, you
> name it).
> If people are interested, I can try to clean this up and post it as an RFC.

I am interested.  We need support for subtype 13, because our hardware 
only supports 32-bit access to all registers.  We have an internal patch 
that replaces all of the read/write routines with vendor function calls. 
  I would need to refactor our patch on top of yours.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
