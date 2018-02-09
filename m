From: jolsa@redhat.com (Jiri Olsa)
Date: Fri, 9 Feb 2018 09:53:45 +0100
Subject: [PATCH 5/9] perf utils: add support for arch standard events
In-Reply-To: <312796a3-9818-7793-9e28-7a686c990977@huawei.com>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
 <1517939104-230881-6-git-send-email-john.garry@huawei.com>
 <20180208135533.GI10234@krava>
 <312796a3-9818-7793-9e28-7a686c990977@huawei.com>
Message-ID: <20180209085345.GA20449@krava>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 08, 2018 at 03:25:30PM +0000, John Garry wrote:
> On 08/02/2018 13:55, Jiri Olsa wrote:
> > On Wed, Feb 07, 2018 at 01:45:00AM +0800, John Garry wrote:
> > 
> > SNIP
> > 
> > > 
> > > +static int is_json_file(const char *name)
> > > +{
> > > +	const char *suffix;
> > > +
> > > +	if (strlen(name) < 5)
> > > +		return 0;
> > > +
> > > +	suffix = name + strlen(name) - 5;
> > > +
> > > +	if (strncmp(suffix, ".json", 5) == 0)
> > > +		return 1;
> > > +	return 0;
> > > +}
> > > +
> > > +static int preprocess_arch_std_files(const char *fpath, const struct stat *sb,
> > > +				int typeflag, struct FTW *ftwbuf)
> > > +{
> > > +	int level = ftwbuf->level;
> > > +	int is_file = typeflag == FTW_F;
> > > +
> > > +	if (level == 1 && is_file && is_json_file(fpath))
> > > +		return json_events(fpath, save_arch_std_events, (void *)sb);
> > 
> > so any .json file will pass..
> 
> Yes, so according to the scheme any architecture JSONs should be placed in
> the arch root folder.
> 
> just wondering you'd want to put
> > some name restriction for recomended events file like this -recomended
> > suffix you used later.. but that can be added later in case we'll
> > need some other json files in here ;-)
> 
> Sorry, but I don't see what the naming restriction would mean in practice.

now any file you add there will be treated as 'recomended' events file,
having them with '-recomended.json' suffix would separate them.. but
as I said it's ok for now

jirka
