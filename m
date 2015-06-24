From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 24 Jun 2015 22:36:45 +0200
Subject: [PATCHv5 2/2] mailbox: Adding driver for Xilinx LogiCORE IP
 mailbox.
In-Reply-To: <1435082402-29239-3-git-send-email-moritz.fischer@ettus.com>
References: <1435082402-29239-1-git-send-email-moritz.fischer@ettus.com>
 <1435082402-29239-3-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1435178205.4528.77.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-06-23 at 11:00 -0700, Moritz Fischer wrote:
> +MODULE_ALIAS("platform:xilinx-mailbox");

So I think this MODULE_ALIAS() is only useful if, in short, there's a
corresponding platform_device created. Ie, a platform_device with a
name "xilinx-mailbox" that will fire of a "MODALIAS=platform:xilinx
-mailbox" when it's created.

I couldn't spot such a platform_device. Provided git grep didn't let me
down here: what breaks if this line is dropped?

Thanks,


Paul Bolle
