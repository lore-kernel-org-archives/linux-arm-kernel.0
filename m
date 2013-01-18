From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 17 Jan 2013 17:26:08 -0800
Subject: [PATCH 4/4 v3] serial: vt8500: Cleanup code using devm_ function
In-Reply-To: <1358363143-7154-5-git-send-email-linux@prisktech.co.nz>
References: <1358363143-7154-1-git-send-email-linux@prisktech.co.nz>
 <1358363143-7154-5-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130118012608.GA28984@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 08:05:43AM +1300, Tony Prisk wrote:
> Convert the last memory allocation (vt8500_port) to use devm_kzalloc
> and remove the fail path cleanup code from vt8500_serial_probe.
> 
> Reorder iomem mapping above clk_enable to simplify fail code. The
> clock is only enabled if all other resources are available.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  drivers/tty/serial/vt8500_serial.c |   13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

As I dropped patch 3, I can't take this one either.

greg k-h
