From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 16 Nov 2009 10:44:56 +0100
Subject: kernel panic - Attempted to kill init
In-Reply-To: <564715.9008.qm@web7604.mail.in.yahoo.com>
References: <564715.9008.qm@web7604.mail.in.yahoo.com>
Message-ID: <20091116094456.GF14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2009 at 12:59:34PM +0530, abhijeet tripathi wrote:
> I am trying to do a nfs booting of arm-pb1176 but I am getting kernel panic "Kernel panic - not syncing: Attempted to kill init!".
> I checked my filesystem and it has "/sbin/init". Please let me know if I am missing anything. Below is the console logs:

You should enable CONFIG_USER_DEBUG and pass user_debug=255 as kernel
parameter. That will give a more verbose debug output.

Most probably, the EABI/OABI settings in your kernel and user space
environment don't match.

Daniel
