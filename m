From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 25 Jan 2017 22:09:19 +0100
Subject: [PATCH v2] i2c: i2c-cadence: Initialize configuration before
 probing devices
In-Reply-To: <1484578178-3165-1-git-send-email-mike.looijmans@topic.nl>
References: <1484578178-3165-1-git-send-email-mike.looijmans@topic.nl>
Message-ID: <20170125210919.x2fwb4lbfuqzyw5p@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 03:49:38PM +0100, Mike Looijmans wrote:
> The cadence I2C driver calls cdns_i2c_writereg(..) to setup a workaround
> in the controller, but did so after calling i2c_add_adapter() which starts
> probing devices on the bus. Change the order so that the configuration is
> completely finished before using the adapter.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/ad4b8124/attachment.sig>
