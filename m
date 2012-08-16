From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 16 Aug 2012 08:43:44 -0400
Subject: PATCH Add support for the Iomega IX2-200 Device Tree
In-Reply-To: <CADhrpJ4EMCuvuynF9x+q-PkNPRBaCD_G_YWbcYVj0UrGRQk5dg@mail.gmail.com>
References: <20120815213221.GE15830@lunn.ch>
 <CADhrpJ4eAUdDaLF8OXvjRf6oA6ya0na-SHYs43eoNwdoEJETpA@mail.gmail.com>
 <20120815215237.GF15830@lunn.ch>
 <CADhrpJ7ANwD4asN4-D9OeicGA_V5-9DZoV9G6dDFZ9taN7AZsg@mail.gmail.com>
 <20120815221613.GH15830@lunn.ch>
 <CADhrpJ66ncpT74ATyvJDXTuJC-zrmh8vQ99RPg0t=XuQ_2RcVA@mail.gmail.com>
 <CADhrpJ4sH9krkrWSoFjCg5jrkompgFY=G8iiXo0xy8_iCKeKxA@mail.gmail.com>
 <CADhrpJ7=5QbivftpcuVdhmcKxp3rjiuKQ4Lrf3NckBwL6YNmPQ@mail.gmail.com>
 <20120815234159.GK22226@titan.lakedaemon.net>
 <CADhrpJ4EMCuvuynF9x+q-PkNPRBaCD_G_YWbcYVj0UrGRQk5dg@mail.gmail.com>
Message-ID: <20120816124344.GM22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 12:52:18AM +0100, alan butler wrote:
> On 16 August 2012 00:41, Jason Cooper <jason@lakedaemon.net> wrote:
...
> > That means gpio_keys_get_devtree_pdata() is returning an error.  Have
> > you tried 'linux,input-type = <0x05>;' ?
> 
> 'inux,input-type = <0x05>' instead of 'linux,code = <...>' in the dts?
> no i havent tried will give it a try now.

no, use both.  Look at the original gpio code you had.  It specified
both the type and the code in the struct.  gpio_keys.txt says when
input-type isn't specified it defaults to EV_KEY, whereas your code set
it to EV_SW (0x05 in include/linux/inputh:181).

hth,

Jason.
