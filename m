From: balbi@ti.com (Felipe Balbi)
Date: Wed, 24 Apr 2013 17:26:15 +0300
Subject: [PATCH 04/10] usb: musb: ux500: harden checks for platform data
In-Reply-To: <5177E57C.3010802@cogentembedded.com>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
 <1366729394-11406-5-git-send-email-lee.jones@linaro.org>
 <5176E927.908@cogentembedded.com>
 <20130424065344.GB17416@gmail.com>
 <5177E57C.3010802@cogentembedded.com>
Message-ID: <20130424142615.GF23081@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 06:00:28PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 24-04-2013 10:53, Lee Jones wrote:
> 
> >>>  	struct musb_hdrc_platform_data *plat = dev->platform_data;
> >>>-	struct ux500_musb_board_data *data = plat->board_data;
> >>>+	struct ux500_musb_board_data *data;
> 
> >>>-	param_array = data->dma_rx_param_array;
> >>>+	param_array = (data) ? data->dma_rx_param_array : NULL;
> 
> >>    Why enclose a simple variable in parens?
> 
> >Because 'data' is a pointer, so it contains a memory location,

heh, I don't think you fully understood Sergei's comment. He's asking
why you used:

	param_array = (data) ? data->dma_rx_param_array : NULL;

instead of:

	param_array = data ? data->dma_rx_param_array : NULL;

He's saying, correctly so, that the parens around data is unnecessary.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130424/be915c41/attachment.sig>
