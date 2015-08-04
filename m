From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 4 Aug 2015 13:03:17 +0300
Subject: [PATCH 9/9] usb: misc: ftdi-elan: Simplify return statement
In-Reply-To: <21701034f1472a3d154c77dd8d8be017565885f6.1438678566.git.skarajga@visteon.com>
References: <cover.1438678566.git.skarajga@visteon.com>
 <21701034f1472a3d154c77dd8d8be017565885f6.1438678566.git.skarajga@visteon.com>
Message-ID: <55C08DE5.3060106@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 8/4/2015 12:12 PM, Karajgaonkar, Saurabh (S.) wrote:

> From: Saurabh Karajgaonkar <skarajga@visteon.com>

> Replace redundant variable use in return statement.

> Signed-off-by: Saurabh Karajgaonkar <skarajga@visteon.com>
> ---
>   drivers/usb/misc/ftdi-elan.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)

> diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
> index 8ab1f8f..1545f12 100644
> --- a/drivers/usb/misc/ftdi-elan.c
> +++ b/drivers/usb/misc/ftdi-elan.c
> @@ -2568,11 +2568,8 @@ static int ftdi_elan_close_controller(struct usb_ftdi *ftdi, int fn)
>   					    0x00);
>   	if (UxxxStatus)
>   		return UxxxStatus;
> -	UxxxStatus = ftdi_elan_read_config(ftdi, activePCIfn | reg, 0,
> +	return ftdi_elan_read_config(ftdi, activePCIfn | reg, 0,
>   					   &pcidata);

    Please keep the continuation line aligned by starting it under 'ftdi'.

[...]
> @@ -2695,11 +2692,8 @@ static int ftdi_elan_setupOHCI(struct usb_ftdi *ftdi)
>   		}
>   	}
>   	if (ftdi->function > 0) {
> -		UxxxStatus = ftdi_elan_setup_controller(ftdi,
> +		return ftdi_elan_setup_controller(ftdi,
>   							ftdi->function - 1);

    Likewise.

[...]

MBR, Sergei
