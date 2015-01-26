From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 26 Jan 2015 17:35:44 +0100
Subject: [PATCHv2] mvebu: add Linksys WRT1900AC (Mamba) support
In-Reply-To: <op.xs086cnu2s3iss@ecaz>
References: <1421687701-5667-1-git-send-email-kaloz@openwrt.org>
 <20150119182113.GH32663@lunn.ch> <op.xsrcplz12s3iss@ecaz>
 <54C51FAA.4080300@gmail.com> <op.xs086cnu2s3iss@ecaz>
Message-ID: <54C66CE0.8070407@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/01/2015 20:16, Imre Kaloz wrote:
> Hi Sebastian,
> 
> On Sun, 25 Jan 2015 17:54:02 +0100, Sebastian Hesselbarth  
> <sebastian.hesselbarth@gmail.com> wrote:
> 
>>> - OpenWrt is the only firmware/stack other than the official one and
>>> people already know this device as "mamba".
>>>
>>> - Let's say the same device gets released under the same name or just
>>> the radios change - so no redesign takes place at all. In my opinion
>>> that hardly justifies adding multiple .dts files just to change the name
>>> of the LEDs to reflect that. I think people who want to run mainline on
>>> their device wouldn't be concerned about seeing a codename, but on the
>>> other hand we could receive patches to "correct" the marketing name in
>>> the LEDs.
>>
>> As soon as you'll discover another "mamba"-based device, you can
>> split-off the common stuff into a linksys-mamba.dtsi and include it
>> into each of the two device dts files.
>>
>> Right now, I'd suggest to have just a single linksys-wrt1900ac.dts.
> 
> Right now the only device using the board is the "mamba" with "WRT1900AC"  
> as the marketing name.
> 
> Let me try to change the question: if we'll have a device made by  
> "Company" called "foobar" marketed as "ABC100", mainline really prefers it  
> to be called "company,abc100" (and hence the leds "abc100:color:label")  
> instead of "company,foobar"?

I don't know if there is a guideline about it but as I wrote in the other
email. Using the marketing name as model and board name as compatible string
would make sens.

> 
> As I've said, the "viper" has been sold as the EA4200v2 and the EA4500.  
> Other than the sticker, it's the same device. So for me calling a single  
> device as "linksys,viper" makes way more sense than creating a  
> linksys-viper.dtsi and have a linksys-ea4200v2.dts and a  
> linksys-ea4500.dts - (so multiple kernels) just to make the model / led  
> name follow the sticker.
> 

>From my point of view the compatible name and dts[i|] files are two separate things.
This kind of information can (would?) be updated by the bootlader either natively
or by using impedance-matcher. It would even be possible to use  dt overlays. We
don't have to provide one dts for any variation of the same board.

Gregory

> Also, please mind we are talking about consumer stuff here, so it's likely  
> there will be multiple versions (maybe with different socs/whatever). Do  
> we really want to have devices named after random marketing name + version  
> number combos? ABC100 can be the same as FOO1000v3 and BAR9999v5 or  
> WTH555v2.
> 
> 
> Imre
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
