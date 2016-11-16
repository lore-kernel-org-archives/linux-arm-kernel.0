From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Nov 2016 09:47:30 -0200
Subject: [PATCH v2] mxs-auart: count FIFO overrun errors
In-Reply-To: <20161116113745.12026-1-weo@reccoware.de>
References: <20161116113745.12026-1-weo@reccoware.de>
Message-ID: <CAOMZO5B1dtHXKfHy1swRYPBQKX5Sw4KpmjZEPqr+nS64HudWJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 9:37 AM, Wolfgang Ocker <weo@reccoware.de> wrote:
> The mxs-auart driver does not count FIFO overrun errors. These errors never
> appear in /proc/tty/driver/ttyAPP. This is because the OERR status bit is
> masked by read_status_mask in the rx interrupt function, but the
> AUART_STAT_OERR bit is never set in read_status_mask. The patch enables the
> counting of overrun errors.
>
> Signed-off-by: Wolfgang Ocker <weo@reccoware.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
