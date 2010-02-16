From: utx@penguin.cz (Stanislav Brabec)
Date: Tue, 16 Feb 2010 09:45:18 +0100
Subject: how to type reverse ' on spitz?
In-Reply-To: <20100216063810.GA1409@ucw.cz>
References: <20100216063810.GA1409@ucw.cz>
Message-ID: <1266309918.2489.50.camel@utx.utx.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek wrote:
> Hi!
> 
> I did not find reverse ' (you know, the one in cat 'which ketchup') in
> the keymap. Is it mapped somewhere I did not look? Where is it mapped
> in X?

No, there is no ` in the default keymap. I propose Fn+d instead of ?
(Katakana middle dot). I guess you can't do it on kernel level, but you
need a special keymap.

Here is my new XKB keymap:
ftp://ftp.penguin.cz/pub/users/utx/zaurus/files/xserver-xorg/
It is still incomplete, but already works pretty well:
- Left Alt on ??/?? = Hiragana_Katakana
- Right Ctrl on ?/? = Hankaku_Zenkaku
- Caps works
- Group switch works on Fn+0 (instead of Alphabet lock)
TODO:
- Why Shift+Insert (Shift+Fn+z) does not work properly in vte terminal
  (i. e. paste buffer)
- Fix F-keys (Right Control = ?/? = Hankaku_Zenkaku) + number should
  generate F-keys, but Left Ctrl should generate Ctrl+number)
- Implement mouse movement

And here is my previous xmodmap (per partes addon to the Angstrom
default):
ftp://ftp.penguin.cz/pub/users/utx/zaurus/files/keyboard/homedir/
It used Fn+a (originally unmapped), but I think Fn+d may be better.


________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
