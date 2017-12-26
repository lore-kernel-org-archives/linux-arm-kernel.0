From: jiri@mellanox.com (Jiri Pirko)
Date: Tue, 26 Dec 2017 09:47:13 +0100
Subject: [patch v15 1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <13433849-cb7d-e2c0-4ce9-d91a6012d7d7@gmail.com>
References: <1514202808-29747-1-git-send-email-oleksandrs@mellanox.com>
 <1514202808-29747-2-git-send-email-oleksandrs@mellanox.com>
 <13433849-cb7d-e2c0-4ce9-d91a6012d7d7@gmail.com>
Message-ID: <20171226084713.GA2175@nanopsycho>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tue, Dec 26, 2017 at 12:09:08AM CET, f.fainelli at gmail.com wrote:
>Le 12/25/17 ? 03:53, Oleksandr Shamray a ?crit?:

[...]

>[snip]
>
>> +
>> +void *jtag_priv(struct jtag *jtag)
>> +{
>> +	return jtag->priv;
>> +}
>> +EXPORT_SYMBOL_GPL(jtag_priv);
>
>Can't you just create a static inline function in the public header for
>that? This is usually what subsystems do, I can understand why you would
>not want to expose struct jtag to other parts of the kernel, but still,
>this looks ugly, so maybe consider splitting the header between provider
>and consumer?

Other subsystems expose the struct. Here, it is intentional to don't
expose the struct, that's why we have this helper. What is ugly about
that? :)
