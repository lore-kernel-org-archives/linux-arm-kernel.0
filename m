From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 24 Oct 2013 11:37:08 -0700
Subject: [PATCH 4/8] input: Remove OOM message after input_allocate_device
In-Reply-To: <cc5e6a317bc9ef33cfdfae3ed9d3a47b5319a47b.1382555436.git.joe@perches.com>
References: <cover.1382555436.git.joe@perches.com>
 <cc5e6a317bc9ef33cfdfae3ed9d3a47b5319a47b.1382555436.git.joe@perches.com>
Message-ID: <20131024183707.GA5281@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

On Wed, Oct 23, 2013 at 12:14:50PM -0700, Joe Perches wrote:
> Emitting an OOM message isn't necessary after input_allocate_device
> as there's a generic OOM and a dump_stack already done.

No, please don't. The kzalloc may get changed in the future to not dump
stack (that was added originally because not everyone was handling OOM
properly, right?), input core might get changed to use something else
than kzalloc, etc, etc.

The majority of errors use dev_err so we also get idea what device
failed (if there are several), and more.

Thanks.

-- 
Dmitry
