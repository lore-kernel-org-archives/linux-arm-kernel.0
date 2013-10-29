From: sre@debian.org (Sebastian Reichel)
Date: Tue, 29 Oct 2013 11:25:28 +0100
Subject: [PATCHv2 1/3] Input: twl4030-keypad - add device tree support
In-Reply-To: <14DEC9DA-8C77-4F73-AF3A-6C0D20C6C1AB@codeaurora.org>
References: <1382446042-27099-1-git-send-email-sre@debian.org>
 <1382446042-27099-2-git-send-email-sre@debian.org>
 <5137C017-2515-427C-865F-B938CC24B210@codeaurora.org>
 <20131029010608.GA5353@earth.universe>
 <14DEC9DA-8C77-4F73-AF3A-6C0D20C6C1AB@codeaurora.org>
Message-ID: <20131029102527.GA10530@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 03:33:31AM -0500, Kumar Gala wrote:
> On Oct 28, 2013, at 8:06 PM, Sebastian Reichel wrote:
> > On Mon, Oct 28, 2013 at 01:42:47AM -0500, Kumar Gala wrote:
> >>> +This binding is based on the matrix-keymap binding with the following
> >>> +changes:
> >> 
> >> Maybe be a bit more specific and say 'based on the input/matrix-keymap.txt binding'..
> > 
> > OK.
> > 
> >>> + * keypad,num-rows and keypad,num-columns are required.
> >> 
> >> Is linux,keymap required from matrix-keymap.txt?
> > 
> > Yes, matrix-keymap.txt contains descriptions for the following:
> > 
> > required:
> > - linux,keymap
> 
> So you don't say that linux,keymap is required for twl4030-keypad
> (wasn't clear if you assumed that or not).

It's already required by matrix-keypad, so I assumed the requirement
is inherited by twl4030-keypad. The other matrix-keymap based
bindings assume the same.

keypad,num-rows and keypad,num-columns are only stated explicitly,
because they are optional in matrix-keymap, but required by
twl4030-keympad.

> > optional:
> > - keypad,num-rows
> > - keypad,num-columns
> > 
> >>> +Optional Properties specific to linux:
> >>> +- linux,keypad-no-autorepeat: do no enable autorepeat feature.
> >> 
> >> Does it make sense to update the matrix-keymap.txt binding to add
> >> 'linux,keypad-no-autorepeat' there?
> > 
> > At least according to devicetree documentation there are
> > keymap-matrix.txt based drivers, which do not support
> > "linux,keypad-no-autorepeat".
> 
> Which is why it could be optional in keymap-matrix.txt.  I dont
> know anything about keymap/keypad's just asking the question?
> 
> It seems as if linux,keypad-no-autorepeat is intended to mean the
> same thing (if relevant to the device) across all drivers.  Is
> that correct?  If so it seems like moving it to be specified in a
> generic input binding makes sense, just not sure if
> keymap-matrix.txt is that place or not.

Yes, when supported it means the same. I can add it to
keymap-matrix.txt.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/e8b1e02f/attachment.sig>
