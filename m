From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Apr 2018 11:42:52 +0100
Subject: [PATCH v2 1/6] spi: core: handle timeout error from transfer_one()
In-Reply-To: <20180404070817.6cens44jvlmdaxtm@flea>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-2-ssuloev@orpaltech.com>
 <20180403155224.GA11578@sirena.org.uk>
 <c0476d75-821f-7a0d-3c3f-270304e7b032@orpaltech.com>
 <20180403161824.GB11578@sirena.org.uk>
 <dad0ea81-2dd6-ccc3-a0c9-cf20ff195b7f@orpaltech.com>
 <20180404070817.6cens44jvlmdaxtm@flea>
Message-ID: <20180404104252.GC7691@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2018 at 09:08:18AM +0200, Maxime Ripard wrote:

> And I'm pretty sure that papering over an error returned by a driver
> is not the right thing to do.

We've got specific error handling for timeouts - they get accounted for
separately in the stats.  It *shouldn't* affect actual operation and
AFAICT it doesn't.  I think the main problem here is that the commit
message is very unclear.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/8f12f834/attachment.sig>
