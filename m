From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 3 Aug 2013 10:07:41 -0400
Subject: [RFC PATCH V2 4/9] s/.name/.compatible/
In-Reply-To: <51FC2A34.8010806@wwwdotorg.org>
References: <cover.1375457714.git.jason@lakedaemon.net>
 <1e66851fa0a7c137afbb39a27c77d5a585b466f6.1375457714.git.jason@lakedaemon.net>
 <51FC2A34.8010806@wwwdotorg.org>
Message-ID: <20130803140741.GH5882@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 03:52:52PM -0600, Stephen Warren wrote:
> On 08/02/2013 09:51 AM, Jason Cooper wrote:
> > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> 
> > diff --git a/board-raumfeld.c b/board-raumfeld.c
> 
> > @@ -21,19 +21,19 @@ static struct board boards[] = {
> >  		.machid		= 2413,
> >  		.system_rev	= 0,
> >  		.dtb		= &_binary_input_raumfeld_controller_0_dtb_start,
> > -		.name		= "Raumfeld Controller, revision 0",
> > +		.compatible	= "Raumfeld Controller, revision 0",
> 
> This looks a little unfortunate; those values don't look like they're
> the contents of the DT compatible property.

Yes, this project is a week old.  I figured a little volatility was
allowed :-)  Please see:

  cb0088e board-raumfeld: tweak compatible strings

in:

  https://github.com/zonque/pxa-impedance-matcher.git

I changed the api so that the user could link in a random number of dtbs
_without_ hardcoding the addresses.  Searching by the compatible string
was the easiest way to accomplish this.  Unfortunately, I didn't know
his compatible strings when I made the change.

For the curious, the code that does this is here:

  https://github.com/zonque/pxa-impedance-matcher/blob/master/dtbs.c

We plan to add dtb parsing in the future so that we can change the dtb
based on the atags passed by the legacy bootloader.

thx,

Jason.
