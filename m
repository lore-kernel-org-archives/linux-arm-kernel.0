From: olof@lixom.net (Olof Johansson)
Date: Mon, 29 Aug 2016 14:39:21 -0700
Subject: [Patch v4 9/9] arm64: Update device tree for Layerscape SoCs
In-Reply-To: <20160829080530.GA25468@nazgul.tnic>
References: <1470780000-16750-1-git-send-email-york.sun@nxp.com>
 <20160812091354.GB333@nazgul.tnic> <20160829063448.GA32489@tiger>
 <20160829080530.GA25468@nazgul.tnic>
Message-ID: <CAOesGMjg3XNrVESr+fS-D5HkwVZEx+ng8TCUriRyohCu0NvJAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 1:05 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Aug 29, 2016 at 02:34:48PM +0800, Shawn Guo wrote:
>> Is it mandatory to have DTS changes go with driver part altogether?
>
> Yes, because the EDAC driver needs them to even load properly.
>
>> Otherwise, I prefer to have them go through separate tree.
>
> Any particular reason why you prefer that?
>
> We've been doing this for other ARM EDAC drivers already and there were
> no issues whatsoever.

DT changes need to go through arm-soc. It's how we've been operating
for several years now.

It can be a huge pain when DT patches get merged through driver trees
and others are also modifying those files. Don't do it. You don't know
if someone else out there is changing these files, that's why we have
maintainers who own them and coordinate the changes.


If there are special circumstances such that the DT contents has to go
in with the same tree, then we can consider alternatives. But I can't
remember having one of those situations for quite a while now.


-Olof
