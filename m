From: henrik@henriknordstrom.net (Henrik =?ISO-8859-1?Q?Nordstr=F6m?=)
Date: Wed, 29 Jan 2014 23:37:59 +0100
Subject: [linux-sunxi] Re: [RFC PATCH v2 09/14] mtd: nand: add sunxi NFC
 dt bindings doc
In-Reply-To: <CAL_JsqLVr1gSLArqtfOiHce+u6ZK8FiKMX0o9bvMrMoGGhATvg@mail.gmail.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
 <1391006064-28890-10-git-send-email-b.brezillon.dev@gmail.com>
 <CAL_JsqLVr1gSLArqtfOiHce+u6ZK8FiKMX0o9bvMrMoGGhATvg@mail.gmail.com>
Message-ID: <1391035079.14902.3.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ons 2014-01-29 klockan 11:11 -0600 skrev Rob Herring:

> Isn't allwinner,rb implied by a lack of rb-gpios property. Or no R/B
> pin is an option? If so, don't you need some fixed time delay
> properties like max erase time?
> 
> rb-gpios could be added to the generic nand binding as well.

The Allwinner NAND controller have dedicated RB pins when NAND is
enabled, only MUXed with other functions when NAND is not enabled.

Leaving RB unconnected is not a valid hardware configuration. The
controller internal timing engine depends on being able to sense RB to
sequence NAND commands properly.

Regards
Henrik
