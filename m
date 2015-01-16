From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 16 Jan 2015 13:02:09 +0200
Subject: [PATCH v5 5/5] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <1421402411-3479-6-git-send-email-chunyan.zhang@spreadtrum.com>
References: <sc9836-v5>
 <1421402411-3479-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1421402411-3479-6-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20150116110209.GA2299@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chunyan Zhang,

On Fri, Jan 16, 2015 at 06:00:11PM +0800, Chunyan Zhang wrote:
> +		if (uart_handle_sysrq_char(port, ch))
> +			continue;

You don't define SUPPORT_SYSRQ, so uart_handle_sysrq_char has no effect. See 
include/linux/serial_core.h.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
