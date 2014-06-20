From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 19 Jun 2014 17:36:09 -0700
Subject: [PATCH v4 10/13] serial: asc: Add support for KGDB's FIQ/NMI mode
In-Reply-To: <1403174303-25456-11-git-send-email-daniel.thompson@linaro.org>
References: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-11-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140620003609.GB30850@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 11:38:20AM +0100, Daniel Thompson wrote:
> Add a .poll_init() function that enables UART RX and registers the
> UART's irq with KGDB. By providing this information to KGDB the serial
> driver offers "permission" for KGDB to route the UART interrupt signal
> from the drivers own handler to KGDBs FIQ handler (which will eventually
> use the UART's polled I/O callbacks to interact with the user).
> 
> Note that the RX is not only enabled but also unmasked. This is required
> because otherwise the FIQ handler could never trigger. This unmask is
> copied from similar code in amba-pl011.c .
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: kernel at stlinux.com
> Cc: linux-serial at vger.kernel.org
> ---
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
