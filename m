From: zonque@gmail.com (Daniel Mack)
Date: Sat, 03 Aug 2013 16:16:09 +0200
Subject: [RFC PATCH V2 4/9] s/.name/.compatible/
In-Reply-To: <20130803140741.GH5882@titan.lakedaemon.net>
References: <cover.1375457714.git.jason@lakedaemon.net>
 <1e66851fa0a7c137afbb39a27c77d5a585b466f6.1375457714.git.jason@lakedaemon.net>
 <51FC2A34.8010806@wwwdotorg.org> <20130803140741.GH5882@titan.lakedaemon.net>
Message-ID: <51FD10A9.9030300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.08.2013 16:07, Jason Cooper wrote:
> I changed the api so that the user could link in a random number of dtbs
> _without_ hardcoding the addresses.  Searching by the compatible string
> was the easiest way to accomplish this.  Unfortunately, I didn't know
> his compatible strings when I made the change.
> 
> For the curious, the code that does this is here:
> 
>   https://github.com/zonque/pxa-impedance-matcher/blob/master/dtbs.c
> 
> We plan to add dtb parsing in the future so that we can change the dtb
> based on the atags passed by the legacy bootloader.

... and then we can also specifically look into the compatible node of
the dtb, and not just do a string search over the entire binary.

But for now, it's good enough.


Daniel
